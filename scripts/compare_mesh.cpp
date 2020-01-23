#include <CGAL/Exact_predicates_inexact_constructions_kernel.h>
#include <CGAL/Polyhedron_items_with_id_3.h>
#include <CGAL/Polyhedron_3.h>
#include <CGAL/Surface_mesh.h>
#include <CGAL/Polygon_mesh_processing/bbox.h>
#include <CGAL/Polygon_mesh_processing/corefinement.h>
#include <CGAL/Polygon_mesh_processing/distance.h>
#include <CGAL/Polygon_mesh_processing/remesh.h>

#include <CGAL/IO/OFF_reader.h>
#include <math.h>

#if defined(CGAL_LINKED_WITH_TBB)
#define TAG CGAL::Parallel_tag
#else
#define TAG CGAL::Sequential_tag
#endif

typedef CGAL::Exact_predicates_inexact_constructions_kernel K;
typedef CGAL::Polyhedron_3<K, CGAL::Polyhedron_items_with_id_3>  Polyhedron;
typedef K::Point_3                     Point;
typedef CGAL::Surface_mesh<K::Point_3> Mesh;

namespace PMP = CGAL::Polygon_mesh_processing;

void print_double(double n) {
  if (isnan(n)) {
    std::cout << "\"nan\"" << std::endl;
  } else if (isinf(n)) {
    std::cout << "\"inf\"" << std::endl;
  } else {
    std::cout << n << std::endl;
  }
}

int main(int argc, char* argv[])
{
  int hausdorff_n;

  if (argc == 2) {
    std::ifstream i1(argv[1]);
    Mesh tm1;
    i1 >> tm1;
    double v1 = CGAL::Polygon_mesh_processing::volume(tm1);
    print_double(v1);
    return 0;
  } else if (argc == 3) {
    hausdorff_n = -1;
  } else if (argc == 4) {
    hausdorff_n = std::stoi(argv[3]);
  } else {
    std::cerr << "Needs two meshes and optionally a number for hausdorff" << std::endl;
    return 1;
  }

  const char* f1  = argv[1];
  const char* f2  = argv[2];

  std::ifstream i1(f1);
  std::ifstream i2(f2);

  if(!i1) {
    std::cerr << "Cannot open file 1" << std::endl;
    return EXIT_FAILURE;
  }
  if(!i2) {
    std::cerr << "Cannot open file 2" << std::endl;
    return EXIT_FAILURE;
  }

  Mesh tm1, tm2;
  i1 >> tm1;
  i2 >> tm2;

  if (hausdorff_n >= 0) {
    CGAL::Bbox_3 bb1 = CGAL::Polygon_mesh_processing::bbox(tm1);
    CGAL::Bbox_3 bb2 = CGAL::Polygon_mesh_processing::bbox(tm2);
    double bb1_xmin = bb1.xmin();
    double bb1_ymin = bb1.ymin();
    double bb1_zmin = bb1.zmin();
    double bb2_xmin = bb2.xmin();
    double bb2_ymin = bb2.ymin();
    double bb2_zmin = bb2.zmin();
    double bb1_xmax = bb1.xmax();
    double bb1_ymax = bb1.ymax();
    double bb1_zmax = bb1.zmax();
    double bb2_xmax = bb2.xmax();
    double bb2_ymax = bb2.ymax();
    double bb2_zmax = bb2.zmax();
    double d1 = sqrt(pow((bb1_xmax - bb1_xmin), 2) + pow((bb1_ymax - bb1_ymin), 2) + pow((bb1_zmax - bb1_zmin), 2));
    double d2 = sqrt(pow((bb2_xmax - bb2_xmin), 2) + pow((bb2_ymax - bb2_ymin), 2) + pow((bb2_zmax - bb2_zmin), 2));
    double bb_diag = std::max(d1, d2);
    double d = CGAL::Polygon_mesh_processing::approximate_Hausdorff_distance<TAG>
      (tm1,
       tm2,
       PMP::parameters::number_of_points_on_edges(hausdorff_n),
       PMP::parameters::number_of_points_on_faces(hausdorff_n)
       );
    double normalized_d = d / bb_diag;
    print_double(normalized_d);
  } else {
    Mesh diff;
    CGAL::Polygon_mesh_processing::corefine_and_compute_difference(tm1, tm2, diff);
    double v1 = CGAL::Polygon_mesh_processing::volume(tm1);
    double v2 = CGAL::Polygon_mesh_processing::volume(tm2);
    double v_diff = CGAL::Polygon_mesh_processing::volume(diff);
    double normalized_v_diff = v_diff / std::max(v1, v2);
    print_double(normalized_v_diff);
  }
}
